#!/usr/bin/env python

from datetime import date
from PIL import Image
import os
import re

#   Cambiar dependiendo del OS
path = os.getenv("HOME") + "/Pictures/Waifus/"
log_file = os.path.dirname(__file__) + "/sort_image_log.txt"
wallpapers_directories = ["Fondos_Cel", "Fondos_PC", "Otros"]
folder_Search = ("[a-zA-Z0-9]*Fondos*", "[a-zA-Z0-9]*Otros*")
folder_Divider = "/"
square_like_size = 200


def createDir(directory_name: str):
    """
    Create a new directory.

    @param directory_name:  the directory to create.
    @type  directory_name:  str

    @return:  None
    @rtype :  None

    @raise OSError:  Description
    """
    try:
        os.mkdir(directory_name)
        print("Carpeta: " + directory_name + " Creada! :D")
    except OSError:
        print("Carpeta " + directory_name + " ya existe! >:c")


def move_directory(file_to_move: str, new_wallpaper_directory: str):
    """
    Move file to new location, if file exist add a number at the end.

    Arguments:
        @param file_to_move:  The file to evaluate.
        @type  file_to_move:  str

        @param new_wallpaper_directory:  The parent directory of the file.
        @type  new_wallpaper_directory:  str
    """
    i = 0
    msg = ""
    base_directory_name = os.path.basename(os.path.dirname(file_to_move))
    base_directory_path = os.path.dirname(os.path.abspath(file_to_move))
    file_name = os.path.basename(file_to_move)
    while True:
        i += 1
        try:
            if i == 1:
                os.rename(
                    file_to_move,
                    f"{base_directory_path}/{base_directory_name}_{new_wallpaper_directory}/{file_name}",
                )
                break
            else:
                old_name = os.path.basename(file_to_move).split(".")
                new_name = f"{old_name[0]}({str(i)}).{old_name[1]}"
                os.rename(
                    file_to_move,
                    f"{base_directory_path}/{base_directory_name}_{new_wallpaper_directory}/{new_name}",
                )
                msg = f"Archivo: {os.path.basename(file_to_move)} Ya existe \nSe renombrará como: {new_name}"
                break
        except Exception as err:
            input()
            print(err)
            continue

    print()
    if i != 1:
        write_to_log(msg + "\n")
        print(msg)
    write_to_log(f"{file_name} Fue movido a: {base_directory_name} \n\n")


def check_files(file_to_check: str):
    """
    Categorize an image base on it's width and height as phone or pc wallpaper.

    @param file_to_check:  The path of the file.
    @type  file_to_check:  str.

    @return:  None.
    @rtype :  None.
    """

    try:
        img = Image.open(file_to_check)  # Abrir imagen
        img_size = img.size  # Conseguir tamaño de la imágen
        img.close()  # Cerrar imágen
        # conseguir el ancho - alto para categorizar la imágen
        size_difference = img_size[0] - img_size[1]
    except:
        print("Archivo no es una imagen, se moverá a otros")
        move_directory(file_to_check, wallpapers_directories[2])
        return

    # si es cuadrada o rectángulo
    if size_difference != 0 and (abs(size_difference) > square_like_size):

        # Imagen no cuadrada
        print(f"{os.path.basename(file_to_check)} Es un Fondo, será movido")

        #   Verificar si es vertical u horizontal
        if size_difference < 0:

            # Es vertical - mover a Fondo_Cel
            move_directory(file_to_check, wallpapers_directories[0])
            print(
                os.path.basename(file_to_check)
                + " Fue movido a: "
                + wallpapers_directories[0]
            )

        else:

            # es horizontal - mover a Fondo_Pc
            move_directory(file_to_check, wallpapers_directories[1])
            print(
                os.path.basename(file_to_check)
                + " Fue movido a: "
                + wallpapers_directories[1]
            )

    else:
        # Imagen es cuadrada - mover a otros
        move_directory(file_to_check, wallpapers_directories[2])
        print(
            os.path.basename(file_to_check)
            + " Fue movido a: "
            + wallpapers_directories[2]
        )


def get_list_of_files(directory_name: str):
    """Get the all the files in the directory recourcively (Recover from stackoverflow).

    @param directory_name:  The name of the directory.
    @type  directory_name:  str.

    @return:  None.
    @rtype :  None.
    """
    # create a list of file and sub directories
    # names in the given directory
    raw_file_list = os.listdir(directory_name)
    file_list = list()
    # Iterate over all the entries
    for entry in raw_file_list:
        # Create full path
        full_path = os.path.join(directory_name, entry)
        # If entry is a directory then get the list of files in this directory
        if os.path.isdir(full_path):
            file_list = file_list + get_list_of_files(full_path)
        else:
            file_list.append(full_path)

    return file_list


def write_to_log(message: str):
    """Write message to the log_file

    @param message:  The message to append to the log file,
    @type  message:  str

    @return:  None.
    @rtype :  None.
    """
    with open(log_file, "a") as file:
        file.write(message)


# Main


def main():
    current_directory = ""

    write_to_log("\n*** " + str(date.today()) + " ***\n")

    # Recorrer todas las carpetas
    file_list = get_list_of_files(path)
    for file_entry in file_list:

        # Saltar carpetas NSFW
        if re.search("NSFW*", os.path.dirname(file_entry)):
            print("Carpeta NSFW! No voy a entrar ahí :c")
            continue

        # No volver a revisar las carpetas ya realizadas
        if re.search(folder_Search[0], os.path.dirname(file_entry)) or re.search(
            folder_Search[1], os.path.dirname(file_entry)
        ):
            print("Directorio ya revisado! :3")
            continue

        # Crear carpetas "Fodo_X_directory" cuando cambie el directorio
        if current_directory != os.path.dirname(file_entry):
            current_directory = os.path.dirname(file_entry)
            parent_wallpaper_directories = []
            for i, dir in enumerate(wallpapers_directories):
                parent_wallpaper_directories.append(
                    f"{current_directory}{folder_Divider}{os.path.basename(current_directory)}_{dir}{folder_Divider}"
                )
                createDir(parent_wallpaper_directories[i])

        # Clasificar archivos
        check_files(file_entry)


if __name__ == "__main__":
    main()
