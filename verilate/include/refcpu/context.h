#pragma once

#include "defs.h"

using ContextVType = decltype(VRefCPU::VTop->core__DOT__ctx);

struct ContextWrapper {
    ContextWrapper(VTopType *_top, const ContextVType &_data)
        : top(_top), data(_data) {}

    auto state() const -> CPUState {
        return static_cast<CPUState>(top->context_t_state(data));
    }
    auto pc() const -> addr_t {
        return top->context_t_pc(data);
    }
    auto instr() const -> word_t {
        return top->context_t_instr(data);
    }
    auto target_id() const -> RegisterID {
        return static_cast<RegisterID>(top->context_t_target_id(data));
    }
    auto r(RegisterID id) -> word_t {
        // since register file is placed at the bottom of
        // the context struct, we can access registers directly
        // in verilated model.

        assert(RegisterID::R0 <= id && id <= RegisterID::RA);
        return data[id];
    }

protected:
    VTopType *top;
    const ContextVType &data;
};
