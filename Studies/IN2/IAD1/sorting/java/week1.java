public class week1 {
	public static void main(String[] args) {
		int[] unsorted = {8, 2, 3, 4, 7, 6, 2, 3, 0, -1, -3};
		
	}

	// Opdracht 2
	// A 0(1)
	public static void O_1 (int[] arr) {
		System.out.println(arr);
	}

	// B 0(n)
	public static void O_n (int[] arr) {
		for (int i = 0; i < arr.length; i++) {
			System.out.println(arr[i]);
		}
	}	

	// C 0(n^2)
	public static void O_n2 (int[] arr) {
		for (int i = 0; i < arr.length; i++) {
			for (int j = 0; j < arr.length; j++) {
				System.out.println("i: " + i);
				System.out.println("j: " + j);	
			}
		}
	}
	
	// D 0(n^3)
	public static void O_n3 (int[] arr) {
		for (int i = 0; i < arr.length; i++) {
			for (int j = 0; j < arr.length; j++) {
				for (int k = 0; k < arr.length; k++) {
					System.out.println("i: " + i + " " + arr[i]);
			  	System.out.println("j: " + j + " " + arr[j]);	
			  	System.out.println("k: " + k + " " + arr[k]);	
				}
			}
		}
	}

	// E O{log n)
	public static void O_log_n (int[] arr) {
		for (int i = 1; i < arr.length; i = i + i) {
			System.out.println(arr[i]);
		}
	}

	// F recursief 0(n)
	public static int factorial(int input) {
		if (input == 0) return 1;

		return factorial(input = input * input -1);
	
	}

  // G recursief O n2
	


	// 4. Selection sort
	public static void selectionSort (int[] arr) {

		for (int i = 0; i < arr.length; i++) {
			int min	= arr[i];
			for (int j = 0; j + i < arr.length; j++) {
				
			}
			
		}
	}
	

	/**
	* Prints the contents of an array of integers.
	*
	* @param arr the array to be printed
	*/
	private static void printArray(int[] arr) {
		for (int i = 0; i < arr.length; i++) {
			System.out.println(arr[i]);
		}
	}
}
