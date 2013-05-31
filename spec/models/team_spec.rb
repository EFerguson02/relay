require 'spec_helper'

describe Team do

Team.new( :name => "Tigers" )


  its "total distance should be the sum of its members' total distances"

  its "goal should be the sum of its members' goals"


end
