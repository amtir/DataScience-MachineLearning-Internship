import numpy as np
import random
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import pygame
import sys

# Define the environment
GRID_SIZE = 5
CARROT_REWARD = 1
SHOCK_PENALTY = -10
EMPTY_REWARD = -0.1  # Small penalty to encourage movement

# Define actions (Up, Down, Left, Right)
ACTIONS = {
    0: (-1, 0),  # Up
    1: (1, 0),   # Down
    2: (0, -1),  # Left
    3: (0, 1)    # Right
}

# Initialize maze
maze = np.zeros((GRID_SIZE, GRID_SIZE))
maze[0, 1] = CARROT_REWARD
maze[0, 3] = CARROT_REWARD
maze[1, 0] = CARROT_REWARD
maze[3, 3] = CARROT_REWARD
maze[0, 0] = SHOCK_PENALTY  # Electric shock

# Initialize Q-table
Q_table = np.zeros((GRID_SIZE, GRID_SIZE, len(ACTIONS)))

# Q-learning parameters
alpha = 0.1  # Learning rate
gamma = 0.9  # Discount factor
epsilon = 0.1  # Exploration rate
episodes = 500  # Training iterations

# Function to get next position
def get_next_position(state, action):
    new_x = max(0, min(GRID_SIZE - 1, state[0] + ACTIONS[action][0]))
    new_y = max(0, min(GRID_SIZE - 1, state[1] + ACTIONS[action][1]))
    return new_x, new_y

# Training loop
for episode in range(episodes):
    state = (GRID_SIZE - 1, GRID_SIZE - 1)  # Start position
    done = False
    
    while not done:
        # Choose action using epsilon-greedy policy
        if random.uniform(0, 1) < epsilon:
            action = random.choice(list(ACTIONS.keys()))  # Explore
        else:
            action = np.argmax(Q_table[state[0], state[1]])  # Exploit
        
        next_state = get_next_position(state, action)
        reward = maze[next_state]
        
        # Q-learning update
        Q_table[state[0], state[1], action] = Q_table[state[0], state[1], action] + alpha * (
            reward + gamma * np.max(Q_table[next_state[0], next_state[1]]) - Q_table[state[0], state[1], action]
        )
        
        state = next_state
        if reward == CARROT_REWARD or reward == SHOCK_PENALTY:
            done = True

# Matplotlib animation
def animate_maze():
    fig, ax = plt.subplots()
    grid_display = np.copy(maze)
    im = ax.imshow(grid_display, cmap='coolwarm', vmin=-10, vmax=1)

    def update(frame):
        state = (GRID_SIZE - 1, GRID_SIZE - 1)
        for _ in range(GRID_SIZE * GRID_SIZE):
            action = np.argmax(Q_table[state[0], state[1]])
            next_state = get_next_position(state, action)
            grid_display[state] = 0  # Clear previous position
            grid_display[next_state] = 0.5  # Highlight movement
            state = next_state
            im.set_data(grid_display)
            plt.pause(0.2)

    ani = animation.FuncAnimation(fig, update, frames=10, repeat=False)
    plt.show()

# Pygame visualization
def pygame_maze():
    pygame.init()
    cell_size = 100
    screen = pygame.display.set_mode((GRID_SIZE * cell_size, GRID_SIZE * cell_size))
    clock = pygame.time.Clock()

    colors = {
        0: (255, 255, 255),
        1: (0, 255, 0),
        -10: (255, 0, 0),
        'rabbit': (0, 0, 255)
    }

    state = (GRID_SIZE - 1, GRID_SIZE - 1)
    running = True

    while running:
        screen.fill((0, 0, 0))
        for i in range(GRID_SIZE):
            for j in range(GRID_SIZE):
                color = colors.get(maze[i, j], (200, 200, 200))
                pygame.draw.rect(screen, color, (j * cell_size, i * cell_size, cell_size, cell_size))
        pygame.draw.rect(screen, colors['rabbit'], (state[1] * cell_size, state[0] * cell_size, cell_size, cell_size))
        
        action = np.argmax(Q_table[state[0], state[1]])
        state = get_next_position(state, action)
        
        pygame.display.flip()
        clock.tick(1)

        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
    
    pygame.quit()

# Run visualizations
animate_maze()
pygame_maze()
