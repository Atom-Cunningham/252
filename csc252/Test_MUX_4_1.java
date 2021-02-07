/*
* Test_MUX_4_1.java
*
* Test case for Simulation 3
*/

public class Test_MUX_4_1 {
    public static void main(String args[]) {
        Sim3_MUX_8by1 mux = new Sim3_MUX_8by1();

        // 8 1-bit inputs
        mux.in[0].set(false);
        mux.in[1].set(true);
        mux.in[2].set(true);
        mux.in[3].set(false);
        mux.in[4].set(true);
        mux.in[5].set(false);
        mux.in[6].set(false);
        mux.in[7].set(false);

        // 3 1-bit control inputs
        mux.control[0].set(false);
        mux.control[1].set(false);
        mux.control[2].set(true);

        mux.execute();

        // Print control bits
        System.out.printf("Control: %s%s%s\n", toBit(mux.control[2].get()), toBit(mux.control[1].get()),
                toBit(mux.control[0].get()));

        // Print input bits
        printInput(mux.in);
        System.out.printf("----------\n");

        // Print result
        System.out.printf("Result: %s", toBit(mux.out.get()));
    }

    private static void printInput(RussWire[] in) {
        System.out.printf("Input:\n");
        for (int i = 0; i < in.length; i++) {
            System.out.printf("  %d:  %s\n", i, toBit(in[i].get()));
        }
    }

    private static String toBit(boolean val) {
        if (val) {
            return "1";
        }
        return "0";
    }
}