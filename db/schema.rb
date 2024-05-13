# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_05_09_073324) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "jwt_denylists", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylists_on_jti"
  end

  create_table "otp_verifications", force: :cascade do |t|
    t.string "verification_medium"
    t.string "medium_value"
    t.integer "code"
    t.datetime "expiry_at"
    t.boolean "verified", default: false
    t.string "verifiable_type"
    t.bigint "verifiable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["verifiable_type", "verifiable_id"], name: "index_otp_verifications_on_verifiable"
  end

  create_table "students", force: :cascade do |t|
    t.string "email", default: ""
    t.string "encrypted_password", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.string "gender"
    t.date "dob"
    t.string "phone_number"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gender"], name: "index_students_on_gender"
    t.index ["phone_number"], name: "index_students_on_phone_number"
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
  end

end
