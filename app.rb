# coding: utf-8

require 'sinatra'

class Password
    @@special = ['/', '\\', '&', '%', '$', '!', '(', ')', '@', '#', '?']
    @@chars = ('a'..'z').to_a + ('0'..'9').to_a + ('A'..'Z').to_a
    @@leetWord = ["h4ck", "5h3ll", "h4x0r", "pwn", "p0p"]
    @@leet = {'o'=> 0, 'O'=>0, 'l'=>1, 'L'=>'1', 'e'=>'3', 'E'=>'3', 'a'=>4, 'A'=>4, 's'=>5, 'S'=>5}

    def initialize(count, special, leet)
        @count = count
        @hasSpecial = special
        @hasLeet = leet
    end

    def generate()
        if @hasSpecial
            @@special.each do|s|
                @@chars << s
            end
        end
        
        if @hasLeet
            @@leet.each do|s|
                @@chars << s
            end
        end

        i = 0
        pwd = ""
        begin
            word = @@chars.sample()
            pwd << word
            i += word.length
        end while i < @count

        if @hasLeet
            pwd = pwd.tr(@@leet.keys.join(), @@leet.values.join())
        end

        return pwd
    end
end

count = 12

if ARGV.length == 1
    count = ARGV[0].to_i
end

get '/' do
    erb :index
end

get '/pwd' do
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'GET'

    pass = Password.new(12, true, false)
    pass.generate()
end

post '/pwd' do
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST'
   
    count = '12'
    special = 'on'
    leet = 'off'

    if params.has_key?('count')
        count = params['count']
    end

    if params.has_key?('special')
        special = params['special']
        puts special
    end

    if params.has_key?('leet')
        leet = params['leet']
    end

    pass = Password.new(count.to_i, special == 'on'?true:false, leet == 'on'?true:false)
    pass.generate()
end
