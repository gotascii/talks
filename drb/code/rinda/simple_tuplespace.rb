#START:body
require 'rinda/tuplespace'
ts = Rinda::TupleSpace.new
#END:body
def fib(n)
  n < 2 ? n : fib(n - 2) + fib(n - 1)
end
#START:body
producer = Thread.new do 
  (1..10).each do |number|
    ts.write([:fib_request, number])
  end
  10.times do
    sleep(rand)
    p ts.take([:fib, nil, nil])
  end
end
consumers = (1..10).map do
  Thread.new do 
    _, number = ts.take([:fib_request, Numeric])
    sleep(rand)
    puts "write result for #{number}"
    ts.write([:fib, number, fib(number)])
  end
end
producer.join; consumers.each {|c| c.join}
#END:body