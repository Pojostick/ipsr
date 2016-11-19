class Mosaic < ActiveRecord::Base
  require 'csv'
  
  serialize :steps, Array
  attr_accessor :step_count
  
  def self.colors
    %w' #3977ad
        #d6b027
        #7b3a42
        #d8a458
        #2d1f54
        #982b31
        #302988
        #73a373
        #71452a
        #d4552a
        #d4d6cb
        #212528
        #5d2a33
        #738a9a
        #c5ba61
        #342222
        #707078
        #c17d58
        #1d5b46
        #bc9596
        #845f8b
        #2b3d3d '
  end
  
  def totalSteps()
    return @stepCount
  end
  
  def step_at_n(n)
    return @steps[n]
  end
  
  def self.to_csv
    attributes = %w{steps grid}
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |mosaic|
        csv << attributes.map{ |attr| mosaic.send(attr) }
      end
    end
  end
  
end
