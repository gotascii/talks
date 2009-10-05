User.all(
  :conditions => {
    # first_name like '%Ben%'
    :first_name_contains => "Ben",        
    # email like '%binarylogic.com'
    :email_ends_with => "binarylogic.com",
    # created_at > Time.now
    :created_after => Time.now,             
    # HOUR(created_at) > 5 (depends on DB type)
    :hour_of_created_at => 5,               
    # relationship attribute searching
    :orders => {
      :line_items => {
        :created_after => Time.now          
      }
    }
  },
  :order_as => "ASC",
  # order user_groups.name ASC
  :order_by => {:user_group => :name}       
)

search = User.new_search
search.conditions.first_name_contains = "Ben"
search.conditions.email_ends_with = "binarylogic.com"
search.conditions.created_after = Time.now
search.conditions.hour_of_created_at = 5
search.conditions.orders.line_items.created_after = Time.now
search.order_as = "ASC"
search.order_by = {:user_group => :name}
search.all

def index
  @search = User.new_search(params[:search])
  @search.per_page = 20
  @search.page = 3
  @users, @users_count = @search.all, @search.count
end

- form_for @search do |f|
  - f.fields_for @search.conditions do |users|
    = users.text_field :first_name_contains
    # nice rails plugin for replacing date_select
    = users.calendar_date_select :created_after
    - users.fields_for users.object.orders do |orders|
      = orders.select :total_gt, (1..100)
  = f.submit "Search"

- unless @users_count.zero?
  %table
    %tr
      %th= order_by_link :account => :name
      %th= order_by_link :first_name
      %th= order_by_link :last_name
      %th= order_by_link :email
    - @users.each do |user|
      %tr
        %td= user.account? ? user.account.name : "-"
        %td= user.first_name
        %td= user.last_name
        %td= user.email

  == Per page: #{per_page_select}
  == Page: #{page_select}
- else
  No users were found.
  
:begins_with                  
:ends_with                    
:equals                       
:greater_than                 
:greater_than_or_equal_to     
:ilike                      
:less_than                    
:less_than_or_equal_to        
:keywords                     
:like                         
:not_begin_with               
:not_end_with                 
:not_equal                    
:not_have_keywords            
:not_ilike                    
:not_like

order_by_link(:first_name)
order_by_link([:first_name, :last_name])
order_by_link({:orders => :total})
order_by_link([{:orders => :total}, :first_name])

@search = User.new_search(:conditions => {:age_gt => 18})
@search.conditions.first_name_contains = "Doc"
# can set this to "true" or "1" or "yes"
@search.conditions.any = true
# will join all conditions with "or" instead of "and"
@search.all

@search = User.new_search(:conditions => {:age_gt => 18})
@search.conditions.or_first_name_contains = "Ben"
@search.conditions.or_last_name_contains = "Johnson"
# the and_ is optional, calling just id_gt is the same thing
@search.conditions.and_id_gt = 5
# will join conditions in the orders they
# were set with their specified join condition
@search.all
# => age > 17 OR first_name like '%Ben%'
# OR lsat_name like '%Johnson%' AND id > 5

@current_user.orders.find(:all, :conditions => {:total_lte => 500})
@current_user.orders.count(:conditions => {:total_lte => 500})
@current_user.orders.sum('total', :conditions => {:total_lte => 500})
@current_user.orders.build_search(:conditions => {:total_lte => 500})

class User < ActiveRecord::Base
  named_scope :sexy, {
    :conditions => {
      :first_name => "Ben",
      :email_ends_with => "binarylogic.com"
    },
    :per_page => 20
  }
end

@search = User.sexy.build_search(:conditions => {:age_lte => 50})
@search = User.sexy.build_search(params[:search])

