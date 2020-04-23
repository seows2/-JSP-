package myapp;

public class SingletonCounter {
	private static int count = 0;
	
	public static int getCount() {
		return count;
	}
	public static void addCount() {
		count++;
	}
}
