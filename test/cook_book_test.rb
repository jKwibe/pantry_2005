require "minitest/autorun"
require './lib/ingredient'
require './lib/recipe'
require "./lib/cook_book"
require "./lib/pantry"

class CookBookTest < Minitest::Test
  def setup
    @pantry = Pantry.new

    @ingredient1 = Ingredient.new({name: "Cheese", unit: "C", calories: 100})
    @ingredient2 = Ingredient.new({name: "Macaroni", unit: "oz", calories: 30})
    @ingredient3 = Ingredient.new({name: "Ground Beef", unit: "oz", calories: 100})
    @ingredient4 = Ingredient.new({name: "Bun", unit: "g", calories: 75})

    @recipe1 = Recipe.new("Mac and Cheese")
    @recipe2 = Recipe.new("Cheese Burger")

    @cookbook = CookBook.new
  end

  def test_cook_book_exists
    assert_instance_of CookBook , @cookbook
  end

  def test_cook_book_has_recipes
    assert_equal [], @cookbook.recipes
  end

  def test_cook_book_can_add_recipes
    @cookbook.add_recipe(@recipe1)
    @cookbook.add_recipe(@recipe2)
    assert_equal [@recipe1, @recipe2], @cookbook.recipes
  end

  def test_cook_book_can_add_recipes
    @recipe1.add_ingredient(@ingredient1, 2)
    @recipe1.add_ingredient(@ingredient2, 8)

    @recipe2.add_ingredient(@ingredient1, 2)
    @recipe2.add_ingredient(@ingredient3, 4)
    @recipe2.add_ingredient(@ingredient4, 1)
    @cookbook.add_recipe(@recipe1)
    @cookbook.add_recipe(@recipe2)
    assert_equal ["Cheese", "Macaroni", "Ground Beef", "Bun"], @cookbook.ingredients
  end

  def test_cookbook_has_highest_calorie_meal
    @recipe1.add_ingredient(@ingredient1, 2)
    @recipe1.add_ingredient(@ingredient2, 8)

    @recipe2.add_ingredient(@ingredient1, 2)
    @recipe2.add_ingredient(@ingredient3, 4)
    @recipe2.add_ingredient(@ingredient4, 1)
    @cookbook.add_recipe(@recipe1)
    @cookbook.add_recipe(@recipe2)
    assert_equal @recipe2 , @cookbook.highest_calorie_meal
  end
end

# pry(main)> recipe2.add_ingredient(ingredient1, 2)
#
# pry(main)> recipe2.add_ingredient(ingredient3, 4)
#
# pry(main)> recipe2.add_ingredient(ingredient4, 1)
#
# pry(main)> recipe1.total_calories
# # => 440
#
# pry(main)> recipe2.total_calories
# # => 675
#
# pry(main)> cookbook.add_recipe(recipe1)
#
# pry(main)> cookbook.add_recipe(recipe2)
#
# pry(main)> cookbook.ingredients
# # => ["Cheese", "Macaroni", "Ground Beef", "Bun"]
#
# pry(main)> cookbook.highest_calorie_meal
# # => #<Recipe:0x00007faae692a110...>
#
# pry(main)> pantry.restock(ingredient1, 5)
#
# pry(main)> pantry.restock(ingredient1, 10)
#
# pry(main)> pantry.enough_ingredients_for?(recipe1)
# # => false
#
# pry(main)> pantry.restock(ingredient2, 7)
#
# pry(main)> pantry.enough_ingredients_for?(recipe1)
# # => false
#
# pry(main)> pantry.restock(ingredient2, 1)
#
# pry(main)> pantry.enough_ingredients_for?(recipe1)
