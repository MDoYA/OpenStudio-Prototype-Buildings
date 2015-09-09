# *********************************************************************
# *  Copyright (c) 2008-2015, Natural Resources Canada
# *  All rights reserved.
# *
# *  This library is free software; you can redistribute it and/or
# *  modify it under the terms of the GNU Lesser General Public
# *  License as published by the Free Software Foundation; either
# *  version 2.1 of the License, or (at your option) any later version.
# *
# *  This library is distributed in the hope that it will be useful,
# *  but WITHOUT ANY WARRANTY; without even the implied warranty of
# *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# *  Lesser General Public License for more details.
# *
# *  You should have received a copy of the GNU Lesser General Public
# *  License along with this library; if not, write to the Free Software
# *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
# **********************************************************************/


require 'openstudio'
require 'openstudio/ruleset/ShowRunnerOutput'
require 'minitest/autorun'
require_relative '../measure.rb'
require 'fileutils'

class ReplaceModel_test < MiniTest::Unit::TestCase

    def test_weather_file()   
    # create an instance of the measure, a runner and an empty model
    model = BTAP::FileIO::load_osm("#{File.dirname(__FILE__)}/5ZoneNoHVAC.osm")
    measure = ReplaceModel.new
    runner = OpenStudio::Ruleset::OSRunner.new
      
    #Set up arcuments 
    arguments = measure.arguments(model)
    argument_map = OpenStudio::Ruleset.convertOSArgumentVectorToMap(arguments)
    
      
    # set argument 0 alternativeModel
    alternativeModel = arguments[0].clone
    assert(alternativeModel.setValue("EnvelopeAndLoadTestModel_01.osm"))
    argument_map["alternativeModel"] = alternativeModel
    
    # set argument 1 osm_directory
    osm_directory = arguments[1].clone
    assert(osm_directory.setValue("#{File.dirname(__FILE__)}/"))
    argument_map["osm_directory"] = osm_directory
      

    # run the measure
    measure.run(model, runner, argument_map)
    #return condition of measure.
    
    assert_equal("Success", runner.result.value.valueName)
  end   

end
