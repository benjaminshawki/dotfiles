import java.util.Arrays;

public class sorting_oefening_1 {
	public static void main(String[] args) {
		int[] unsorted = {8, 2, 3, 4, 7, 6, 2, 3, 0, -1, -3};

		System.out.println("\nThe Unsorted array:");
		printArray(unsorted);

    System.out.println("\nThe selection sorted array:");
    shuffle(unsorted);
    printArray(unsorted);
		selectionSort(unsorted);
    printArray(unsorted);

//    System.out.println("\nThe bubble sorted array:");
//    shuffle(unsorted);
//    printArray(unsorted);
//    bubbleSort(unsorted);
//    printArray(unsorted);
//
//    System.out.println("\nThe insertion sorted array:");
//    shuffle(unsorted);
//    printArray(unsorted);
//    insertionSort(unsorted);
//    printArray(unsorted);
//
//    System.out.println("\nThe merge sorted array:");
//    shuffle(unsorted);
//    printArray(unsorted);
//    mergeSort(unsorted);
//    printArray(unsorted);
//
//    System.out.println("\nThe quick sorted array:");
//    shuffle(unsorted);
//    printArray(unsorted);
//    quickSort(unsorted, 0, unsorted.length - 1);
//    printArray(unsorted);
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
        if (arr[j] < arr[min]) min = j;
      }

      if (min != i) {
        int tmp = arr[i];
        arr[i] = arr[min];
        arr[min] = tmp;
      }
    }
	}

  private static void bubbleSort(int[] arr) {
  }

  private static void insertionSort(int[] arr) {
  }

  private static void mergeSort(int[] arr) {
  }

  private static void merge(int[] arr, int[] left, int[] right) {
  }

  private static void quickSort(int[] arr, int low, int high) {
  }

  private static int partition(int[] arr, int low, int high) {
    return 0;
  }

  private static int[] heapSort(int[] arr) {
    int n = arr.length;

    for (int i =  n / 2 - 1; i >= 0; i--){
      heapify(arr, n, i);
    }

    for (int i = n - 1; i >= 0; i--){
      int tmp = arr[0];
      arr[0] = arr[n];
      arr[n] = tmp;

      heapify(arr, i, 0);
    }
    return arr;

  }

  private static void heapify(int[] arr, int n, int i) {
    int largest = i;
    int l = i * 2 + 1;
    int r = i * 2 + 2;

    if (l < n && arr[l] > arr[largest]) {
      largest = l;
    }

    if (r < n && arr[r] > arr[largest]) {
      largest = r;
    }

    if (largest != i) {
      tmp = arr[i];
      arr[i] = arr[largest];
      arr[largest] = tmp;

      heapify(arr, n, largest);
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
