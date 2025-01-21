import time
import random

def generate_random_list(n):
    """Generates a list of n unique random numbers."""
    return random.sample(range(n*10), n)

def add_to_hashtable(list):
    """Adds elements from a list to a Hashtable."""
    return {element: True for element in list}

def measure_search_time(hashtable, search_elements):
    """Measures the time it takes to search for elements in the Hashtable."""
    start_time = time.time()
    for element in search_elements:
        _ = hashtable.get(element, None)
    end_time = time.time()
    return end_time - start_time

def main():
    sizes = [100, 1000, 10000, 100000]
    search_attempts = 100  # Number of searches to calculate the average search time

    for size in sizes:
        list = generate_random_list(size)
        hashtable = add_to_hashtable(list)
        search_elements = random.choices(list, k=search_attempts)
        total_time = measure_search_time(hashtable, search_elements)
        print(f"Size: {size}, Average search time (per element): {total_time / search_attempts:.8f} seconds")

if __name__ == "__main__":
    main()
