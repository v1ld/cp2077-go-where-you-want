// Go Where You Want; (c) v1ld, 2022-03-11
// MIT License applies

// Bypass skill checks by replacing this.m_baseSkill.Evaluate(requester) with true everywhere
// Could just return true, but this.m_additionalRequirements.Evaluate(requester) may be useful
@wrapMethod(SkillCheckBase)
  public const func Evaluate(requester: ref<GameObject>) -> Bool {
    let skillCheckPassed: Bool;
    if this.IsActive() {
      if IsDefined(this.m_additionalRequirements) && this.m_additionalRequirements.GetGroupsAmount() > 0 {
        if Equals(this.m_additionalRequirements.GetOperator(), ELogicOperator.AND) {
          skillCheckPassed = this.m_additionalRequirements.Evaluate(requester); // && this.m_baseSkill.Evaluate(requester)
        } else {
          if Equals(this.m_additionalRequirements.GetOperator(), ELogicOperator.OR) {
            skillCheckPassed = true; // || this.m_additionalRequirements.Evaluate(requester);
          };
        };
      } else {
        skillCheckPassed = true; // this.m_baseSkill.Evaluate(requester);
      };
    };
    return skillCheckPassed;
  }