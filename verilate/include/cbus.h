#pragma once

#include "common.h"

using CBusRespVType = uint64_t;

enum class AXISize {
    MSIZE1, MSIZE2, MSIZE4
};

enum class AXILength {
    MLEN1  = 0b0000,
    MLEN2  = 0b0001,
    MLEN4  = 0b0011,
    MLEN8  = 0b0111,
    MLEN16 = 0b1111,
};

/**
 * this class should be implemented by each verilated model.
 */
class CBusInterface {
public:
    static constexpr auto make_response(
        bool ready, bool last, uint32_t data
    ) -> CBusRespVType {
        return data | (uint64_t(ready) << 33) | (uint64_t(last) << 32);
    }

    virtual auto valid()    -> bool      = 0;
    virtual auto is_write() -> bool      = 0;
    virtual auto size()     -> AXISize   = 0;
    virtual auto addr()     -> uint32_t  = 0;
    virtual auto strobe()   -> uint8_t   = 0;
    virtual auto data()     -> uint32_t  = 0;
    virtual auto len()      -> AXILength = 0;
};
