# frozen_string_literal: true

require_relative "test_helper"

module SassC
  class CSSColorLevel4Test < MiniTest::Test
    include FixtureHelper

    def test_rgb_with_space_separated_values_and_alpha_slash
      assert_sass <<-SCSS, <<-CSS
        div { color: rgb(100% 0% 0% / 50%); }
      SCSS
        div { color: rgba(255, 0, 0, 0.5); }
      CSS
    end

    def test_rgb_with_space_separated_values_without_alpha
      assert_sass <<-SCSS, <<-CSS
        div { color: rgb(100% 0% 0%); }
      SCSS
        div { color: red; }
      CSS
    end

    def test_rgb_with_numeric_values_and_alpha_slash
      assert_sass <<-SCSS, <<-CSS
        div { color: rgb(255 0 0 / 0.5); }
      SCSS
        div { color: rgba(255, 0, 0, 0.5); }
      CSS
    end

    def test_rgb_with_numeric_values_and_percent_alpha
      assert_sass <<-SCSS, <<-CSS
        div { color: rgb(255 0 0 / 100%); }
      SCSS
        div { color: red; }
      CSS
    end

    def test_rgba_with_space_separated_values_and_alpha_slash
      assert_sass <<-SCSS, <<-CSS
        div { color: rgba(50% 100% 0% / 75%); }
      SCSS
        div { color: rgba(128, 255, 0, 0.75); }
      CSS
    end

    def test_hsl_with_space_separated_values_and_alpha_slash
      assert_sass <<-SCSS, <<-CSS
        div { color: hsl(120deg 100% 50% / 50%); }
      SCSS
        div { color: rgba(0, 255, 0, 0.5); }
      CSS
    end

    def test_hsl_with_space_separated_values_without_alpha
      assert_sass <<-SCSS, <<-CSS
        div { color: hsl(240deg 100% 50%); }
      SCSS
        div { color: blue; }
      CSS
    end

    def test_hsl_without_deg_unit
      assert_sass <<-SCSS, <<-CSS
        div { color: hsl(180 50% 50% / 0.8); }
      SCSS
        div { color: rgba(64, 191, 191, 0.8); }
      CSS
    end

    def test_hsla_with_space_separated_values_and_alpha_slash
      assert_sass <<-SCSS, <<-CSS
        div { color: hsla(0deg 100% 50% / 25%); }
      SCSS
        div { color: red; }
      CSS
    end

    def test_mixed_color_syntax_in_same_file
      assert_sass <<-SCSS, <<-CSS
        .old-rgb { color: rgb(255, 0, 0); }
        .new-rgb { color: rgb(255 0 0 / 0.5); }
        .old-hsl { color: hsl(120, 100%, 50%); }
        .new-hsl { color: hsl(120deg 100% 50% / 0.5); }
      SCSS
        .old-rgb { color: red; }
        .new-rgb { color: rgba(255, 0, 0, 0.5); }
        .old-hsl { color: lime; }
        .new-hsl { color: rgba(0, 255, 0, 0.5); }
      CSS
    end

    def test_rgb_with_zero_alpha
      assert_sass <<-SCSS, <<-CSS
        div { color: rgb(255 128 64 / 0%); }
      SCSS
        div { color: rgba(255, 128, 64, 0); }
      CSS
    end

    def test_hsl_with_full_alpha
      assert_sass <<-SCSS, <<-CSS
        div { color: hsl(60deg 100% 50% / 100%); }
      SCSS
        div { color: yellow; }
      CSS
    end

    def test_rgb_with_decimal_alpha
      assert_sass <<-SCSS, <<-CSS
        div { color: rgb(200 100 50 / 0.333); }
      SCSS
        div { color: rgba(200, 100, 50, 0.333); }
      CSS
    end

    def test_hsl_with_decimal_alpha
      assert_sass <<-SCSS, <<-CSS
        div { color: hsl(90 80% 60% / 0.666); }
      SCSS
        div { color: rgba(153, 235, 71, 0.666); }
      CSS
    end

    def test_rgb_percent_mixed_with_alpha
      assert_sass <<-SCSS, <<-CSS
        div { color: rgb(50% 25% 75% / 0.5); }
      SCSS
        div { color: rgba(128, 64, 191, 0.5); }
      CSS
    end

    def test_hsl_with_turn_unit
      assert_sass <<-SCSS, <<-CSS
        div { color: hsl(0.5turn 50% 50% / 50%); }
      SCSS
        div { color: rgba(191, 65, 64, 0.5); }
      CSS
    end

    def test_hsl_with_rad_unit
      assert_sass <<-SCSS, <<-CSS
        div { color: hsl(3.14159rad 100% 50% / 80%); }
      SCSS
        div { color: rgba(255, 13, 0, 0.8); }
      CSS
    end

    def test_hsl_with_grad_unit
      assert_sass <<-SCSS, <<-CSS
        div { color: hsl(200grad 50% 50% / 60%); }
      SCSS
        div { color: rgba(64, 149, 191, 0.6); }
      CSS
    end

    private

    def assert_sass(sass, expected_css)
      engine = Engine.new(sass)
      assert_equal expected_css.strip.gsub(/\s+/, " "), # poor man's String#squish
                   engine.render.strip.gsub(/\s+/, " ")
    end
  end
end

