
class CookBook
  attr_reader :recipes
  def initialize
    @recipes  = []
  end

  def add_recipe(recipe)
    @recipes << recipe
  end

  def ingredients
    ingredients = @recipes.flat_map do |recipe|
      recipe.ingredients_required
    end
    ingredients.flat_map {|ing| ing.map {|k,v|k.name }}.uniq
  end

  def highest_calorie_meal
    @recipes.max_by do |recipe|
      recipe.total_calories
    end
  end
end
