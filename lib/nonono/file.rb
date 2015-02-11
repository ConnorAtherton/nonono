class File
  TAIL_BUF_LENGTH = 1 << 16

  def tail(n)
    return [] if n < 1

    seek -TAIL_BUF_LENGTH, SEEK_END

    buf = ""
    while buf.count("\n") <= n
      buf = read(TAIL_BUF_LENGTH) + buf
      seek 2 * -TAIL_BUF_LENGTH, SEEK_CUR
    end

    buf.split("\n")[-n..-1]
  end
end
