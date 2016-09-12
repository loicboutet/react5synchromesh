class ApplicationPolicy
  always_allow_connection
  regulate_all_broadcasts { |policy| policy.send_all }
end
