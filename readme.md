Proyecto game genesis! creado por Matias Reyes, este consiste en generacion de niveles usando inteligencia artificial, a continuación observara un paso a paso de como hacer funcionar este proyecto:

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

python -m venv gamegenesis_env

gamegenesis_env\Scripts\activate

python instalar_dependencias.py          
python generador_avanzado.py

Esto generara niveles, los niveles generados se pasan de la carpeta levels (python) a la carpeta levels (dentro de godot).

Una vez hecho esto, se ejecuta godot y podras acceder a la interfaz de usuario, la cual te guiara y es intuitiva para el uso del proyecto, disfruta!
