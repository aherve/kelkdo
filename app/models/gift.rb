class Gift
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :recipient, type: String
  field :context, type: String

  belongs_to :author, class_name: "User", inverse_of: :gifts

  class << self

    def acceptable_contextes
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

    def acceptable_recipients
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
