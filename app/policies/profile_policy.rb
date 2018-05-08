class ProfilePolicy < ApplicationPolicy

    def update?
        user == record.user
    end

    def edit?
        user == record.user
    end

    def destroy?
        user == record.user
    end

    def Index
        user.admin
    end

end