import java.util.Arrays;

public class sorting {
	public static void main(String[] args) {

		int[] unsorted = {8, 2, 3, 4, 7, 6, 2, 3, 0, -1, -3};

		System.out.println("\nThe Unsorted array:");
		printArray(unsorted);

    System.out.println("\nThe selection sorted array:");
    shuffle(unsorted);
    printArray(unsorted);
		selectionSort(unsorted);
    printArray(unsorted);

    System.out.println("\nThe bubble sorted array:");
    shuffle(unsorted);
    printArray(unsorted);
    bubbleSort(unsorted);
    printArray(unsorted);

    System.out.println("\nThe insertion sorted array:");
    shuffle(unsorted);
    printArray(unsorted);
    insertionSort(unsorted);
    printArray(unsorted);

    System.out.println("\nThe merge sorted array:");
    shuffle(unsorted);
    printArray(unsorted);
    mergeSort(unsorted);
    printArray(unsorted);

    System.out.println("\nThe quick sorted array:");
    shuffle(unsorted);
    printArray(unsorted);
    quickSort(unsorted, 0, unsorted.length - 1);
    printArray(unsorted);
	}


  /**
  * Sorts an array of integers in ascending order using the selection sort algorithm.
  *
  * @param arr the array to be sorted
  */
	private static void selectionSort(int[] arr) {
		for (int i = 0; i < arr.length; i++) {
			int min = i;

			for (int j = i + 1; j < arr.length; j++) {
				if ( arr[j] < arr[min] ) min = j;
			}

			// Swap the found minimum element with the first element
			if (min != i) {
				int tmp = arr[min];
				arr[min] = arr[i];
				arr[i] = tmp;
			}
		}
	}

  private static void bubbleSort(int[] arr) {
    for (int i = 0; i < arr.length; i++) {
      for (int j = 0; j < arr.length - 1; j++) {
        if (arr[j] > arr[j + 1]) {
          int tmp = arr[j];
          arr[j] = arr[j + 1];
          arr[j + 1] = tmp;
        }
      }
    }
  }

  private static void insertionSort(int[] arr) {
    for (int i = 1; i < arr.length; i++) {
      int key = arr[i];
      int j = i - 1;

      while (j >= 0 && arr[j] > key) {
        arr[j + 1] = arr[j];
        j--;
      }

      arr[j + 1] = key;
    }
  }

  private static void mergeSort(int[] arr) {
    if (arr.length > 1) {
      int mid = arr.length / 2;
      int[] left = new int[mid];
      int[] right = new int[arr.length - mid];

      for (int i = 0; i < mid; i++) {
        left[i] = arr[i];
      }

      for (int i = mid; i < arr.length; i++) {
        right[i - mid] = arr[i];
      }

      mergeSort(left);
      mergeSort(right);
      merge(arr, left, right);
    }
  }

  private static void merge(int[] arr, int[] left, int[] right) {
    int i = 0, j = 0, k = 0;

    while (i < left.length && j < right.length) {
      if (left[i] <= right[j]) {
        arr[k] = left[i];
        i++;
      } else {
        arr[k] = right[j];
        j++;
      }
      k++;
    }

    while (i < left.length) {
      arr[k] = left[i];
      i++;
      k++;
    }

    while (j < right.length) {
      arr[k] = right[j];
      j++;
      k++;
    }
  }

  private static void quickSort(int[] arr, int low, int high) {
    if (low < high) {
      int pi = partition(arr, low, high);

      quickSort(arr, low, pi - 1);
      quickSort(arr, pi + 1, high);
    }
  }

  private static int partition(int[] arr, int low, int high) {
    int pivot = arr[high];
    int i = low - 1;

    for (int j = low; j < high; j++) {
      if (arr[j] < pivot) {
        i++;

        int tmp = arr[i];
        arr[i] = arr[j];
        arr[j] = tmp;
      }
    }

    int tmp = arr[i + 1];
    arr[i + 1] = arr[high];
    arr[high] = tmp;

    return i + 1;
  }


  private static int[] heapSort(int[] array) {
      int arrayLength = array.length;

      // Build heap (rearrange array)
      for (int i = arrayLength / 2 - 1; i >= 0; i--) {
          heapify(array, arrayLength, i);
      }

      // One by one extract an element from heap
      for (int i = arrayLength - 1; i >= 0; i--) {
          // Move current root to end
          int temp = array[0];
          array[0] = array[i];
          array[i] = temp;

          // call max heapify on the reduced heap
          heapify(array, i, 0);
      }

      return array;
  }

  private static void heapify(int[] array, int heapSize, int rootIndex) {
      int largestIndex = rootIndex; // Initialize largest as root
      int leftChildIndex = 2 * rootIndex + 1; // left = 2*i + 1
      int rightChildIndex = 2 * rootIndex + 2; // right = 2*i + 2

      // If left child is larger than root
      if (leftChildIndex < heapSize && array[leftChildIndex] > array[largestIndex]) {
          largestIndex = leftChildIndex;
      }

      // If right child is larger than largest so far
      if (rightChildIndex < heapSize && array[rightChildIndex] > array[largestIndex]) {
          largestIndex = rightChildIndex;
      }

      // If largest is not root
      if (largestIndex != rootIndex) {
          int swapTemp = array[rootIndex];
          array[rootIndex] = array[largestIndex];
          array[largestIndex] = swapTemp;

          // Recursively heapify the affected sub-tree
          heapify(array, heapSize, largestIndex);
      }
  }

  private static void shuffle(int[] arr) {
    for (int i = 0; i < arr.length; i++) {
      int r = (int) (Math.random() * (i + 1));
      int tmp = arr[r];
      arr[r] = arr[i];
      arr[i] = tmp;
    }
  }

	/**
	* Prints the contents of an array of integers.
	*
	* @param arr the array to be printed
	*/
	private static void printArray(int[] arr) {
    System.out.println(Arrays.toString(arr));
	}
}
