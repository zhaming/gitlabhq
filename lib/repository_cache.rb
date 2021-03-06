# Interface to the Redis-backed cache store used by the Repository model
class RepositoryCache
  attr_reader :namespace

  def initialize(namespace, backend = Rails.cache)
    @namespace = namespace
    @backend = backend
  end

  def cache_key(type)
    "#{type}:#{namespace}"
  end

  def expire(key)
    backend.delete(cache_key(key))
  end

  def fetch(key, &block)
    backend.fetch(cache_key(key), &block)
  end

  private

  attr_reader :backend
end
