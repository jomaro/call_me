defmodule CallMe.Maybe do
  @moduledoc """
  Documentation for `CallMe`.
  """

  @type maybe() :: any() | nil

  @doc """

  ## Examples

      iex> CallMe.Maybe.expect(:cat, "So sorry mr Schrodinger")
      :cat

  """
  @spec expect(maybe(), String.t()) :: any
  def expect(nil, reason) do
    Process.exit(self(), reason)
  end
  def expect(other_thing, _reason) do
    other_thing
  end

  @doc """

  ## Examples

      iex> CallMe.Maybe.unwrap_or_else(:cat, fn -> :dog end)
      :cat

      iex> CallMe.Maybe.unwrap_or_else(nil, fn -> :dog end)
      :dog

  """
  def unwrap_or_else(nil, callback) do
    callback.()
  end
  def unwrap_or_else(value, _callback) do
    value
  end

  @doc """

  ## Examples

      iex> CallMe.Maybe.map(7, fn value -> value * 6 end)
      42

      iex> CallMe.Maybe.map(nil, fn value -> value * 6 end)
      nil

  """
  def map(nil, _callback) do
    nil
  end
  def map(value, callback) do
    callback.(value)
  end

  @doc """

  ## Examples

      iex> CallMe.Maybe.map_or(7, fn value -> value * 6 end, 0)
      42

      iex> CallMe.Maybe.map_or(nil, fn value -> value * 6 end, 0)
      0

  """
  def map_or(nil, _callback, default) do
    default
  end
  def map_or(value, callback, _default) do
    callback.(value)
  end

  @doc """

  ## Examples

      iex> CallMe.Maybe.ok_or(7, 0)
      7

      iex> CallMe.Maybe.ok_or(nil, 0)
      0

  """
  def ok_or(nil, default) do
    default
  end
  def ok_or(value, _default) do
    value
  end

  @doc """

  ## Examples

      iex> CallMe.Maybe.and_(7, 0)
      0

      iex> CallMe.Maybe.and_(nil, 0)
      nil

      iex> CallMe.Maybe.and_(nil, nil)
      nil

      iex> CallMe.Maybe.and_(nil, 0)
      nil

  """
  def and_(nil, _other) do
    nil
  end
  def and_(_other, nil) do
    nil
  end
  def and_(_value, otto_value) do
    otto_value
  end

  @doc """

  ## Examples

      iex> CallMe.Maybe.and_then(7, fn value -> value * 6 end)
      42

      iex> CallMe.Maybe.and_then(nil, fn value -> value * 6 end)
      nil

  """
  def and_then(nil, _callback) do
    nil
  end
  def and_then(value, callback) do
    callback.(value)
  end

  @doc """

  ## Examples

      iex> CallMe.Maybe.filter(7, &is_integer/1)
      7

      iex> CallMe.Maybe.filter(7.5, &is_integer/1)
      nil

      iex> CallMe.Maybe.filter(nil, &is_integer/1)
      nil

  """
  def filter(nil, _callback) do
    nil
  end
  def filter(value, callback) do
    if callback.(value) do
      value
    end
  end
end
