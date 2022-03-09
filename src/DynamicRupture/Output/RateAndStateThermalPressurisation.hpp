#ifndef SEISSOL_DR_OUTPUT_RS_TP_HPP
#define SEISSOL_DR_OUTPUT_RS_TP_HPP

#include "DynamicRupture/Output/Base.hpp"

namespace seissol::dr::output {
class RateAndStateThermalPressurisation : public RateAndState {
  public:
  using RateAndState::postCompute;
  using RateAndState::RateAndState;
  using RateAndState::tiePointers;

  protected:
  real computePf() override { return 0.0; }
  void outputSpecifics(OutputData& outputData, size_t level, size_t receiverIdx) override {
    auto& tpVariables = std::get<VariableID::TpVariables>(outputData.vars);
    if (tpVariables.isActive) {
      using DrLtsDescrT = seissol::initializers::LTS_RateAndStateThermalPressurisation;
      auto* temperature = local.layer->var(static_cast<DrLtsDescrT*>(drDescr)->temperature);
      tpVariables(TPID::Temperature, level, receiverIdx) = temperature[local.ltsId][local.nearestGpIndex];

      auto* pressure = local.layer->var(static_cast<DrLtsDescrT*>(drDescr)->pressure);
      tpVariables(TPID::Pressure, level, receiverIdx) = pressure[local.ltsId][local.nearestGpIndex];
    }
  }
};
} // namespace seissol::dr::output

#endif // SEISSOL_DR_OUTPUT_RS_TP_HPP
