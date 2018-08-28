module MemFs
  class Pathname
    include FilesystemAccess

    def initialize(path)
      @path = path
    end

    def children(with_directory=true)
      with_directory = false if @path == '.'
      result = []
      fs.entries(@path).each do |e|
        next if e == '.' || e == '..'
        if with_directory
          result << self.class.new(OriginalFile.join(@path, e))
        else
          result << self.class.new(e)
        end
      end
      result
    end

    def exist?
      !!fs.find(to_s)
    end

    def cleanpath(consider_symlink=false)
      self.class.new(OriginalPathname.new(@path).cleanpath(consider_symlink).to_s)
    end

    def to_s
      @path
    end

    def +(other)
      self.class.new((OriginalPathname.new(@path) / other).to_s)
    end
    alias / +
  end
end

