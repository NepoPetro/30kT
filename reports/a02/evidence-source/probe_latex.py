from manim import *

class LatexProbe(Scene):
    def construct(self):
        eq = MathTex(r"R = \frac{N_{\text{doc}}}{N_{\text{decl}}}")
        self.play(Write(eq), run_time=1.5)
        self.wait(0.5)