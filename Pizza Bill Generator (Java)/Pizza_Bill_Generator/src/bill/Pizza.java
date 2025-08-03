package bill;

public class Pizza {

    private int price;
    private final boolean isVeg;
    private String bill;


    private final int extraCheesePrice = 100;
    private final int extraToppingsPrice = 150;
    private final int takeawayPrice = 20;

    private int basePizzaPrice;
    private boolean isExtraCheeseAdded = false;
    private boolean isExtraToppingsAdded = false;
    private boolean isOptedForTakeaway = false;


    public Pizza(boolean isVeg) {
        this.isVeg = isVeg;
        if (this.isVeg) {
            this.price = 300;
        } else {
            this.price = 400;
        }
        basePizzaPrice = this.price;
    }


    public void addExtraCheese() {
        if (!isExtraCheeseAdded) {
            this.price += extraCheesePrice;
            isExtraCheeseAdded = true;
        }
    }


    public void addExtraToppings() {
        if (!isExtraToppingsAdded) {
            this.price += extraToppingsPrice;
            isExtraToppingsAdded = true;
        }
    }


    public void addTakeaway() {
        if (!isOptedForTakeaway) {
            this.price += takeawayPrice;
            isOptedForTakeaway = true;
        }
    }


    public void getBill() {
        StringBuilder billBuilder = new StringBuilder();
        billBuilder.append("Base Pizza Price: ").append(this.basePizzaPrice).append("\n");

        if (isExtraCheeseAdded) {
            billBuilder.append("Extra Cheese Added: ").append(extraCheesePrice).append("\n");
        }
        if (isExtraToppingsAdded) {
            billBuilder.append("Extra Toppings Added: ").append(extraToppingsPrice).append("\n");
        }
        if (isOptedForTakeaway) {
            billBuilder.append("Take Away: ").append(takeawayPrice).append("\n");
        }

        billBuilder.append("Total Bill: ").append(this.price).append("\n");
        this.bill = billBuilder.toString();

        System.out.println("--------------------BILL--------------------");
        System.out.println(this.bill);
        System.out.println("------------------------------------------");
    }
}