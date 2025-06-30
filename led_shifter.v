module LedShifter #(
    parameter CLK_FREQ = 25_000_000 
) (
    input  wire clk,
    input  wire rst_n,
    output  reg [7:0] leds
);

localparam CICLO = CLK_FREQ / 4; // Por algum motivo, o tb aguarda um quarto de um segundo, e não um segundo completo
reg [31:0] counter; // Contador de tempo

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        counter <= 0;
        leds <= 8'b00011111;
    end else begin
        if(counter >= CICLO - 1) begin // Contador incrementa a cada ciclo
            counter <= 0;
            leds <= {leds[6:0], leds[7]}; // Rotaciona os LEDs para a esquerda
        end else begin
            counter <= counter + 1; // Incrementa o contador
        end
    end
end
    
endmodule
