/*
 * Test_ALU_7_ADD_0.java
 *
 * Test case for Simulation 3
 */

public class Test_ALU_7_ADD_0 {
    public static void main(String args[]) {
        Sim3_ALU alu = new Sim3_ALU(7);

        alu.a[0].set(false);
		alu.a[1].set(true);
		alu.a[2].set(false);
		alu.a[3].set(true);
		alu.a[4].set(true);
		alu.a[5].set(true);
		alu.a[6].set(true);
		
		alu.b[0].set(true);
		alu.b[1].set(true);
		alu.b[2].set(true);
		alu.b[3].set(false);
		alu.b[4].set(true);
		alu.b[5].set(true);
		alu.b[6].set(true);

        alu.aluOp[0].set(false);
        alu.aluOp[1].set(true);
        alu.aluOp[2].set(false);

        alu.bNegate.set(true);

        alu.execute();

        // Print inputs
        System.out.printf("Inputs:\n");

        System.out.print("  a: ");
        print_bits(alu.a);
        System.out.print("\n");

        System.out.print("  b: ");
        print_bits(alu.b);
        System.out.print("\n");

        System.out.printf("  bNegate: %s\n", toBit(alu.bNegate.get()));
        
		System.out.printf("  aluOp: ");
		print_bits(alu.aluOp);
		System.out.print("\n\n");

        // Print output
        System.out.printf("Output:\n");
        System.out.print("  result: ");
        print_bits(alu.result);
        System.out.print("\n");

    }

    public static void print_bits(RussWire[] bits)
    {
        for (int i=bits.length-1; i>=0; i--)
        {
            if (bits[i].get())
                System.out.print("1");
            else
                System.out.print("0");
        }
    }

    private static String toBit(boolean val) {
        if (val) {
            return "1";
        }
        return "0";
    }
}