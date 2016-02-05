class ArticlePolicy
  attr_reader :user, :article

  def initialize(user, article)
    @user = user
    @article = article
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    !@user.nil?
  end

  def new?
    create?
  end

  def update?
    @article.user == @user
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end
