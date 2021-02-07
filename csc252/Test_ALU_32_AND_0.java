/*
 * Test_ALU_32_AND_0.java
 *
 * Test case for Simulation 3
 */

public class Test_ALU_32_AND_0 {
    public static void main(String args[]) {
        Sim3_ALU alu = new Sim3_ALU(32);

        alu.a[0].set(false);
		alu.a[1].set(true);
		alu.a[2].set(false);
		alu.a[3].set(true);
		alu.a[4].set(true);
		alu.a[5].set(true);
		alu.a[6].set(true);
		alu.a[7].set(false);
		alu.a[8].set(true);
		alu.a[9].set(false);
		alu.a[10].set(true);
		alu.a[11].set(true);
		alu.a[12].set(true);
		alu.a[13].set(true);
		alu.a[14].set(false);
		alu.a[15].set(true);
		alu.a[16].set(false);
		alu.a[17].set(true);
		alu.a[18].set(true);
		alu.a[19].set(true);
		alu.a[20].set(true);
		alu.a[21].set(false);
		alu.a[22].set(true);
		alu.a[23].set(false);
		alu.a[24].set(true);
		alu.a[25].set(true);
		alu.a[26].set(true);
		alu.a[27].set(true);
		alu.a[28].set(false);
		alu.a[29].set(true);
		alu.a[30].set(false);
		alu.a[31].set(false);
		
		alu.b[0].set(true);
		alu.b[1].set(true);
		alu.b[2].set(true);
		alu.b[3].set(false);
		alu.b[4].set(true);
		alu.b[5].set(true);
		alu.b[6].set(true);
		alu.b[7].set(true);
		alu.b[8].set(true);
		alu.b[9].set(true);
		alu.b[10].set(false);
		alu.b[11].set(true);
		alu.b[12].set(true);
		alu.b[13].set(true);
		alu.b[14].set(true);
		alu.b[15].set(true);
		alu.b[16].set(true);
		alu.b[17].set(false);
		alu.b[18].set(true);
		alu.b[19].set(true);
		alu.b[20].set(true);
		alu.b[21].set(true);
		alu.b[22].set(true);
		alu.b[23].set(true);
		alu.b[24].set(false);
		alu.b[25].set(true);
		alu.b[26].set(true);
		alu.b[27].set(true);
		alu.b[28].set(true);
		alu.b[29].set(true);
		alu.b[30].set(true);
		alu.b[31].set(false);

        alu.aluOp[0].set(false);
        alu.aluOp[1].set(false);
        alu.aluOp[2].set(false);

        alu.bNegate.set(false);

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