class Recipe
  attr_reader :name, :description, :prep_time, :difficulty

  def initialize(name, description, prep_time = 0, done = false, difficulty = 1)
    @name = name
    @description = description
    @prep_time = prep_time
    @done = done
    @difficulty = difficulty
  end

  def done?
    return @done
  end

  def done!
    @done = true
  end

  def how_difficult?
    case @difficulty
    when 1 then "Very Easy"
    when 2 then "Easy"
    when 3 then "Moderate"
    when 4 then "Difficult"
    end
  end
end