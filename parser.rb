require 'json'
require 'pry'
require 'csv'


class Parser

  def initialize
    @file = File.read('quillgrammar-concepts-export.json')
    @csv_arrays = [['Concept Level 0', 'Concept Level 1', 'CCSS Standard',	'Question UID',	'Answers', 'Prompt']]
    @questions_hash = JSON.parse(@file)
    @missing_fields = ["-Jzw0qjO5owyFPUAwDGK", "-Jzw0qjLNEeZAERlRksx", "-Jzw0qjO5owyFPUAwDGM", "-K2nXnevRx0EgXW07mzg", "-K2iV539jnRtCyoWKh3N"]
  end

  # -Jzw0qjO5owyFPUAwDGK -- "Meanwhile"
  # -Jzw0qjO5owyFPUAwDGM -- "Meanwhile"
  # '-K2nXnevRx0EgXW07mzg' --  no questions
  # -Jzw0qjLNEeZAERlRksx -- correct messy sentences
  # -K2iV539jnRtCyoWKh3N" -- 'Colons in lists' is missing concept level 0 


  def json_to_array
    @questions_hash.each do |concept|
      unless @missing_fields.include?(concept.first)
        ccss = concept[1]["standard"]["name"]
        concept_level_0 = concept[1]['concept_level_0']['name']
        concept_level_1 = concept[1]['concept_level_1']['name']
        puts concept_level_0
        concept[1]["questions"].each do |question|
          question_uid = question.first[1..-1]
          answers = question[1]['answers']
          prompt = question[1]['prompt']
          @csv_arrays.push([concept_level_0, concept_level_1, ccss, question_uid, answers, prompt])
        end
      end
    end
  end

  def json_to_csv
    json_to_array
    CSV.open("questions.csv", "w") do |csv|
      @csv_arrays.each {|q| csv << q}
    end
  end

end

c = Parser.new
c.json_to_csv
