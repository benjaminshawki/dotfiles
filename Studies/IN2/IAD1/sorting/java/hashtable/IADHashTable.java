import java.util.Arrays;
import java.util.Objects;

@SuppressWarnings("unchecked")
public class IADHashTable<KEY, VALUE> {
    private static class Map<KEY, VALUE> {
        private KEY key;
        private VALUE value;
        private Map<KEY, VALUE> next;
        private Map(KEY key, VALUE value) {
            this.key = key;
            this.value = value;
        }

        public void setValue(KEY key, VALUE value) {
            if(this.key.equals(key)) {
                this.value = value;
            } else {
                if (this.next == null) {
                    this.next = new Map<>(key,value);
                } else {
                    this.next.setValue(key,value);
                }
            }
        }

        public VALUE getValue(@NonNull KEY key) {
            if (this.key.equals(key)) {
                return this.value;
            }
            else {
                return next == null? null : next.getValue(key);
            }
        }

    }

    private final Map<KEY, VALUE>[] data;

    public IADHashTable(final int size) {
        this.data = new Map[size];
    }

    public IADHashTable() {
        this(10);
    }

    private int getPosition(@NonNull KEY key) {
        return key.hashCode() % this.data.length;
    }

    public float getLoadFactor() {
        final float k = this.data.length;
        final float n = k - (float)Arrays.stream(this.data).filter(Objects::isNull).count();
        return n / k;
    }

    public void set(@NonNull KEY key, VALUE value) {
        if (this.data[getPosition(key)] == null) {
            this.data[getPosition(key)] = new Map<>(key,value);
        }
        else {
            this.data[getPosition(key)].setValue(key,value);
        }
    }

    public VALUE get(@NonNull KEY key) {
        final Map<KEY, VALUE> data = this.data[getPosition(key)];
        if(data == null) {
            return null;
        }
        return data.getValue(key);
    }
}
