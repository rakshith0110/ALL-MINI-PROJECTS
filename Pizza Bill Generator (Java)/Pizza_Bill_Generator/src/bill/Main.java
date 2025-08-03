package bill;

import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.println("--- Welcome to Pizzamania ---");
        System.out.println("Which pizza would you like to order?");
        System.out.println("1. Veg Pizza");
        System.out.println("2. Non-Veg Pizza");
        System.out.println("3. Delux Veg Pizza");
        System.out.println("4. Delux Non-Veg Pizza");

        System.out.print("Enter your choice (1-4): ");
        int choice = scanner.nextInt();

        Pizza pizza = null;

        switch (choice) {
            case 1:
                pizza = new Pizza(true);
                System.out.println("Veg Pizza selected.");
                break;
            case 2:
                pizza = new Pizza(false);
                System.out.println("Non-Veg Pizza selected.");
                break;
            case 3:
                pizza = new DeluxPizza(true);
                System.out.println("Delux Veg Pizza selected.");
                break;
            case 4:
                pizza = new DeluxPizza(false);
                System.out.println("Delux Non-Veg Pizza selected.");
                break;
            default:
                System.out.println("Invalid choice. Please select a valid option.");
                break;
        }

        if (pizza != null) {
            if (!(pizza instanceof DeluxPizza)) {
                System.out.print("Do you want extra cheese? (y/n): ");
                if (scanner.next().equalsIgnoreCase("y")) {
                    pizza.addExtraCheese();
                }
                System.out.print("Do you want extra toppings? (y/n): ");
                if (scanner.next().equalsIgnoreCase("y")) {
                    pizza.addExtraToppings();
                }
            }

            System.out.print("Do you want to opt for takeaway? (y/n): ");
            if (scanner.next().equalsIgnoreCase("y")) {
                pizza.addTakeaway();
            }

            pizza.getBill();
        }

        scanner.close();
    }
}