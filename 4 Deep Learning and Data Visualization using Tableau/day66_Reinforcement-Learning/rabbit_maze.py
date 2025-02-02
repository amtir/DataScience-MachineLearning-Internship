import numpy as np
import random
import matplotlib.pyplot as plt

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

# Visualizing the learned policy
def plot_policy(Q_table):
    policy_grid = np.full((GRID_SIZE, GRID_SIZE), ' ')
    arrows = {0: '↑', 1: '↓', 2: '←', 3: '→'}
    for i in range(GRID_SIZE):
        for j in range(GRID_SIZE):
            best_action = np.argmax(Q_table[i, j])
            policy_grid[i, j] = arrows[best_action]
    print("Learned Policy:")
    print(policy_grid)

plot_policy(Q_table)
