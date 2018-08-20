class Racer
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :id,         type: String
  field :number, type: Integer
  field :first_name, type: String
  field :last_name, type: String
  field :gender, type: String
  field :secs, type: Integer
  def created_at
    nil
  end
  def updated_at
    nil
  end
end
#  include ActiveModel::Model
#
#  attr_accessor :gender, :secs, :number, :first_name, :last_name
#  def initialize(params={})
#    @id=params[:_id].nil? ? params[:id] : params[:_id]
#    @number=params[:number]
#    @first_name=params[:first_name]
#    @last_name=params[:last_name]
#    @gender=params[:gender]
#    @secs=params[:secs]
#  end
#
#  def persisted?
#    !@id.nil?
#  end
#  def created_at
#    nil
#  end
#  def updated_at
#    nil
#  end
#
#  def self.all(prototype={}, sort={:secs=>1}, offset=0, limit=100)
#    #map internal :population term to :pop document term
#    tmp = {} #hash needs to stay in stable order provided
#    sort.each {|k,v|
#      tmp[k] = v  if [:gender, :secs, :number, :first_name, :last_name]
#    }
#    sort=tmp
#
#    #convert to keys and then eliminate any properties not of interest
#    prototype=prototype.symbolize_keys.slice(:gender, :secs, :number, :first_name, :last_name) if !prototype.nil?
#
#    Rails.logger.debug {"getting all racers, prototype=#{prototype}, sort=#{sort}, offset=#{offset}, limit=#{limit}"}
#
#    result=collection.find(prototype)
#      .projection({_id:true, gender:true, secs:true, number:true, first_name:true, last_name:true})
#      .sort(sort)
#      .skip(offset)
#    result=result.limit(limit) if !limit.nil?
#
#    return result
#  end
#
#  def self.paginate(params)
#    Rails.logger.debug("paginate(#{params})")
#    page=(params[:page] ||= 1).to_i
#    limit=(params[:per_page] ||= 30).to_i
#    offset=(page-1)*limit
#    sort=params[:sort] ||= {}
#
#    racers=[]
#    all(params, sort, offset, limit).each do |doc|
#      racers << Race.new(doc)
#    end
#
#    #get a count of all documents in the collection
#    total=all(params, sort, 0, 1).count
#
#    WillPaginate::Collection.create(page, limit, total) do |pager|
#      pager.replace(racers)
#    end
#  end
#
#  def self.find id
#    Rails.logger.debug {"getting zip #{id}"}
#
#    doc=collection.find(:_id=>id)
#      .projection({_id:true, gender:true, secs:true, number:true, first_name:true, last_name:true})
#      .first
#    return doc.nil? ? nil : Zip.new(doc)
#  end
#
#  # create a new document using the current instance
#  def save
#    Rails.logger.debug {"saving #{self}"}
#
#    result=self.class.collection
#      .insert_one(_id:@id, gender:@gender, secs:@secs, number:@number, first_name: @first_name, last_name: @last_name)
#    @id=result.inserted_id
#  end
#
#  # update the values for this instance
#  def update(updates)
#    Rails.logger.debug {"updating #{self} with #{updates}"}
#
#    #map internal :population term to :pop document term
#    updates.slice!(:gender, :secs, :number, :first_name, :last_name) if !updates.nil?
#
#    self.class.collection
#      .find(_id:@id)
#      .update_one(:$set=>updates)
#  end
#
#  # remove the document associated with this instance form the DB
#  def destroy
#    Rails.logger.debug {"destroying #{self}"}
#
#    self.class.collection
#      .find(_id:@id)
#      .delete_one
#  end
#
#end
