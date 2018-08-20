class Racer
  include Mongoid::Document
  include ActiveModel::Model
  attr_accessor :id, :number, :gender, :group, :secs, :first_name, :last_name

  def self.mongo_client
  	Mongo::Client.new('mongodb://localhost:27017')
  end

  def self.collection
  	self.mongo_client['racers']
  end

  def created_at
    nil
  end
  def updated_at
    nil
  end

  def persisted?
    !@id.nil?
  end

  def self.all(prototype={}, sort={:number => 1}, skip=0, limit=nil)
  	result = collection.find(prototype).sort(sort).skip(skip)
  	result = result.limit(limit) if !limit.nil?
  	result
  end

  def initialize(params={})
  	@id=params[:_id].nil? ? params[:id] : params[:_id].to_s
  	@number=params[:number].to_i
  	@first_name=params[:first_name]
  	@last_name=params[:last_name]
  	@gender=params[:gender]
  	@group=params[:group]
  	@secs=params[:secs].to_i
  end

  def self.find(id)
  	result=collection.find(:_id => BSON::ObjectId.from_string(id))
  					 .projection({_id:true, number:true, gender:true, group:true, secs:true, first_name:true, last_name:true}).first
  	return result.nil? ? nil : Racer.new(result)
  end

  def save
  	result = self.class.collection.insert_one(number:@number, gender: @gender, group: @group, secs: @secs, first_name: @first_name, last_name: @last_name)
  	@id = result.inserted_id.to_s
  end

  #Updates database based on hash
  def update(params)
  	@number=params[:number].to_i
  	@first_name=params[:first_name]
  	@last_name=params[:last_name]
  	@secs=params[:secs].to_i
  	@gender=params[:gender]
  	@group=params[:group]

  	params.slice!(:number, :gender, :group, :secs, :first_name, :last_name)
	  self.class.collection.find(:_id=>BSON::ObjectId.from_string(@id)).replace_one(params)
  end

  def destroy
  	self.class.collection.find(_id:BSON::ObjectId.from_string(@id)).delete_one()
  end

  def self.paginate(params)
    page=(params[:page] || 1).to_i
    limit=(params[:per_page] || 30).to_i
    skip=(page-1)*limit
    sort = params[:first_name] || {}

    racers=[]
    all({}, sort, skip, limit).each do |doc|
      racers << Racer.new(doc)
    end

    total = all().count

    WillPaginate::Collection.create(page, limit, total) do |pager|
      pager.replace(racers)
    end
  end
end
