class NotesController < ApplicationController
  
  before_action :set_user
  before_action :set_note, only: [:show, :update, :edit, :destroy]
  before_action :logged_in_user
  before_action :correct_user
  
  def index
    @notes = @user.notes.all
  end
  
  def show
    @note = @user.notes.find(params[:id])
  end
  
  def new
    @note = Note.new
  end
  
  def create
    @note = @user.notes.create(note_params)
    if @note.save
      flash[:success] = "Note created!"
      redirect_to user_notes_url
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @note.update(note_params)
      flash[:success] = "Note updated!"
      redirect_to user_note_url
    else
      render 'edit'
    end
  end
  
  def destroy
    if @note.destroy
      flash[:success] = "Note deleted!"
    else
      flash[:danger]  = "Error deleting note!"
    end
    redirect_to user_notes_url
  end
  
  
  private
    
    def set_user
      @user = User.find(params[:user_id])
    end
    
    def set_note
      @note = @user.notes.find(params[:id])
    end
    
    def note_params
      params.require(:note).permit(:title, :content)
    end
    
end
