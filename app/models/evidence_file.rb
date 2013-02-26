class EvidenceFile
  include Mongoid::Document

  belongs_to :user
  
end
