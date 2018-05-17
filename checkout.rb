repo_map = {}
File.open("dependency.properties", "r").each_line do |line|
  line = line.strip
  if line.size > 0
    r, v = line.split("=")
	if r != nil && v != nil
	  repo_map[r] = v
	end
  end
end
repo_map.each do |r, v|
   d = r.sub("java-", "")
   url = "https://your-user-id@bitbucket.org/your-project/#{r}.git"
   puts "trying to clone #{r} into #{d} from #{url}"
   puts ">>>: ERROR on checking out" unless system("git clone #{url} #{d}")
   puts "\tswitch to  #{v} version"
   puts "\t>>>: ERROR on version switch" unless system("cd #{d}; git checkout #{v}")
   system("cd #{d}; rm -rf .git .gitignore")
   puts ">>>: OK\n"
end

