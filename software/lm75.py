class LM75(object):
    ADDRESS = 0x48  # LM75 bus address
    FREQUENCY = 100000  # I2C bus frequency

    def __init__(self):
        pass
    
    def get_output(self):
        """Return raw output from the LM75 sensor."""
        output = self.i2c.readfrom(self.ADDRESS, 2)
        return output[0], output[1]

    
    def get_temp(self):
        """Return a tuple of (temp_c, point)."""
        temp = self.get_output()
        return int(temp[0]), floor(int(temp[1]) / 23)