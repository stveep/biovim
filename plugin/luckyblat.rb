require 'uri'
require 'open3'
class LuckyBlat

  class << self
    attr_accessor :url_base, :url, :location_regexp, :url_regexp
  end

  @url_base = ENV['UCSC_URL'] || "https://genome-euro.ucsc.edu/cgi-bin"
  @url = @url_base.sub(/\/$/,"") + "/hgBlat"
  @location_regexp = /hgTracks\?position=([^&]+)&/
  @url_regexp = /\/cgi-bin(\/hgTracks.+)'\);/ 

  def initialize(seq)
    @seq = seq.strip.gsub(/\s/,'')
  end

  def curl(opts)
    opts = opts.merge({"Lucky" => "I'm feeling lucky", 
		       "command" => "start",
	               "userSeq" => @seq})
    opts_string = URI.encode_www_form(opts)
    command =  "curl -s -d '" + opts_string + "' #{ LuckyBlat.url }"
    Open3.capture2(command)
  end

  def blat(output=:pos,db="hg38",type="BLAT's guess")
    page = curl({"type" => type, 
	      "db" => db})[0]
    if page.match LuckyBlat.location_regexp
      case output
        when :url
  	  LuckyBlat.url_base + page.match(LuckyBlat.url_regexp)[1]
        else
          $~[1]
	end
    else
      "No match"
    end
  end
end
