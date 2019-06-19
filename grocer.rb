require 'pry'
def consolidate_cart(cart)
  # code here
  cart.each do |item|
    counter = cart.count(item)
    item.each do |name, values|
      values[:count] = counter
    end
  end
  cart = cart.reduce Hash.new, :merge
  cart
end

def apply_coupons(cart, coupons)
  # code here
  
  carthash = cart
  coupons.each do |couponhash|
    itemname = couponhash[:item]

    if !carthash[itemname].nil? && carthash[itemname][:count] >= couponhash[:num]
      tomerge = {
        "#{itemname} W/COUPON" =>
        {
          :price => couponhash[:cost],
          :clearance => carthash[itemname][:clearance],
          :count => 1
        }
      }
      
      if carthash["#{itemname} W/COUPON"].nil?
        carthash.merge!(tomerge)
      else
        carthash["#{itemname} W/COUPON"][:count] += 1
      end

      carthash[itemname][:count] -= couponhash[:num]
    
    end
  end
  carthash
  
end

def apply_clearance(cart)
  # code here
  cart.each do |item, atts|
    if atts[:clearance] == true
      atts[:price] = (atts[:price] * 0.8).round(2)    
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  completecart = consolidate_cart(cart)

  completecart1 = apply_coupons(completecart, coupons)
  completecart2 = apply_clearance(completecart1)
  totalprice = 0

  completecart2.each do |item, values|
    totalprice += values[:price] * values[:count]
  end

  if totalprice > 100
    totalprice = totalprice * 0.9
  end

  totalprice

end
