class Gift
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :recipient, type: String
  field :context, type: String

  belongs_to :author, class_name: "User", inverse_of: :gifts

  validates_presence_of :name

  class << self

    def acceptable_recipients
      [
        "mon frere" ,
        "ma soeur"  ,
        "môman"     ,
        "papa"      ,
        "mon neveu" ,
        "ma niece"  ,
        "ma copine" ,
        "mon copain",
      ]
    end

    def acceptable_contextes
      [
        "noël"            ,
        "son anniversaire",
        "sa fête"         ,
        "rien"            ,
        "m'excuser"       ,
        "pécho"           ,
        "faire plaisir"   ,
      ]
    end

  end

end
