#!/usr/bin/ruby

require 'find'
require 'rake'

# Search and replace in the CMakeList.txt files to make this kde5 built on qt5
def fixCMakeFiles(st)
	# Once things have been added/backedup, we don't need to do this again
	#sh "git add #{st}"
	#sh "cp #{st} #{st}.bak"

	# We don't need to work on backup copies
	if st =~ /bak$/
		return
	end

	fr = File.open("#{st}.bak", "r") 
	fw = File.open("#{st}", "w") 
	fr.each{ |line|
		puts line
	}
	fw.close()
	fr.close()
end

Find.find('./') do |f|
	if f.include? "CMakeLists.txt"
		fixCMakeFiles(f)
	end
end
