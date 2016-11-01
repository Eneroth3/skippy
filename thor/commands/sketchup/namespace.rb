class Skippy::Namespace

  def initialize(namespace)
    unless valid?(namespace)
      raise Skippy::Error, "'#{namespace}' is not a valid Ruby namespace"
    end
    @namespace = namespace
  end

  def basename
    to_a.last
  end

  def to_a
    parts(@namespace)
  end

  def to_name
    basename_words(basename).join(' ')
  end

  def to_s
    @namespace.dup
  end

  def to_underscore
    basename_words(basename).map { |word| word.downcase }.join('_')
  end

  private

  def basename_words(namespace_basename)
    result = namespace_basename.scan(/[[:upper:]]+[[:lower:][:digit:]]*/)
    result.empty? ? [namespace_basename.dup] : result
  end

  def parts(namespace)
    namespace.split('::')
  end

  def valid?(namespace)
    parts(namespace).all? { |part| /^[[:upper:]]/.match(part) }
  end

end