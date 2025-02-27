const rl = @import("raylib");

const WIDTH: i32 = 96;
const HEIGHT: i32 = 54;

pub fn main() !void {
    const program = "+++++>++++>+++>++>+>";
    var programStep: usize = 0;

    var tape: [WIDTH * HEIGHT]u8 = undefined;
    @memset(&tape, 0);
    var tapeIndex: usize = 0;

    var bracketList: [1024]usize = undefined;
    @memset(&bracketList, 0);
    var bracketListIndex: usize = 0;

    rl.initWindow(0, 0, "BF Visualizer");
    defer rl.closeWindow();
    rl.toggleFullscreen();

    rl.setTargetFPS(10000000);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        defer programStep = 0;

        for (0..program.len) |_| {
            const screenWidth = rl.getScreenWidth();
            const screenHeight = rl.getScreenHeight();

            const blockWidth = @divTrunc(screenWidth, WIDTH);
            const blockHeight = @divTrunc(screenHeight, HEIGHT);

            switch (program[programStep]) {
                '>' => {
                    tapeIndex += 1;
                },
                '<' => {
                    tapeIndex -= 1;
                },
                '+' => {
                    tape[tapeIndex % tape.len] +%= 1;
                },
                '-' => {
                    tape[tapeIndex % tape.len] -%= 1;
                },
                '[' => {
                    bracketList[bracketListIndex] = programStep;
                    bracketListIndex += 1;
                },
                ']' => {
                    if (tape[tapeIndex % tape.len] != 0) {
                        programStep = bracketList[bracketListIndex];
                        bracketListIndex -= 1;
                    }
                },
                else => {},
            }
            programStep += 1;

            for (0..WIDTH) |i| {
                for (0..HEIGHT) |j| {
                    const shade = tape[WIDTH * j + i];
                    // const color = rl.Color.init(shade, shade, shade, 255);
                    const color = rl.Color.init(0, shade, 0, 255);

                    const posX = blockWidth * @as(i32, @intCast(i));
                    const posY = blockHeight * @as(i32, @intCast(j));
                    rl.drawRectangle(posX, posY, blockWidth, blockHeight, color);
                }
            }
        }
    }
}
