package hashtable;

public class Car {
  public int hashCode() {
    return 1;
  }

  public static void main(String[] args) {
    IADHashTable table = new IADHashTable();
    for (int j = 0; j < 100; j++) {
      table.put(hashCode(), "Car " + i);
    }
    system.out.println(table);
  }
}
