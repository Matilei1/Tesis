import random
import json

class LevelGenerator:
    def __init__(self, width=10, height=10):
        self.width = width
        self.height = height
        self.tile_types = {
            0: "empty",      # Espacio vacío
            1: "ground",     # Suelo
            2: "wall",       # Pared
            3: "player",     # Posición inicial
            4: "exit"        # Salida
        }
    
    def generate_basic_level(self):
        """Genera una matriz básica de nivel"""
        matrix = [[1 for _ in range(self.width)] for _ in range(self.height)]
        
        # Crear plataforma básica
        for y in range(1, self.height-1):
            for x in range(1, self.width-1):
                if random.random() > 0.2:  # 80% de suelo
                    matrix[y][x] = 0
        
        # Posicionar jugador y salida
        matrix[1][1] = 3  # Jugador
        matrix[self.height-2][self.width-2] = 4  # Salida
        
        return matrix
    
    def save_to_json(self, matrix, filename):
        """Guarda la matriz en formato JSON para Godot"""
        level_data = {
            "width": self.width,
            "height": self.height,
            "tiles": matrix,
            "tile_types": self.tile_types
        }
        
        with open(filename, 'w') as f:
            json.dump(level_data, f, indent=2)

# Uso básico
if __name__ == "__main__":
    generator = LevelGenerator(15, 10)
    level_matrix = generator.generate_basic_level()
    generator.save_to_json(level_matrix, "level_001.json")
    
    print("Matriz generada:")
    for row in level_matrix:
        print(row)